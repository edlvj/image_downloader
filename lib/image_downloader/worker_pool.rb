# frozen_string_literal: true

module ImageDownloader
  class WorkerPool
    def initialize(num_workers)
      @close_channel = new_channel
      @num_jobs = 0
      @num_workers = num_workers
      @work_channel = new_channel
      @workers = num_workers.times.map { |i| new_worker(i) }
    end

    def execute(job)
      @num_jobs += 1
      @work_channel.send([:job, job])
    end

    def close
      @num_workers.times.each do
        @close_channel << [:close]
      end
      @workers.each(&:take)
    end


    def wait
      @num_jobs.times.each do
        _r, res= Ractor.select(*@workers)
        job, duration = res
        puts "job '#{job.name}' took #{duration}s"
      end
    end

    private 

    def new_channel
      Ractor.new do
        loop do
          Ractor.yield Ractor.receive
        end
      end
    end
  
    def new_worker(worker_num)
      Ractor.new(@work_channel, @close_channel, name: "worker-#{worker_num}") do |work_channel, close_channel| 
        loop do
          case Ractor.select(work_channel, close_channel)
          in _, [:job, job]
            start = Time.now
            _res = job.perform
            Ractor.yield([job, Time.now - start])

            in _, [:close]
              puts "#{name}: closing"
              break

            else
              puts "received unknown message: #{message}"
            end
          end
        end
      end
  end
end