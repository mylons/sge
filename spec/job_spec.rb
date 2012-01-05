require 'spec_helper'

describe SGE::Job do
  it {SGE::Job.should be_const_defined(:ATTRIBUTES) }
  it { should respond_to(:job_number) }
  it { should respond_to(:priority) }
  it { should respond_to(:name) }
  it { should respond_to(:queue_name) }
  it { should respond_to(:start_time) }
  it { should respond_to(:slots) }
  it { should respond_to(:state) }
  it { should respond_to(:owner) }

  it { should respond_to(:job_number=) }
  it { should respond_to(:priority=) }
  it { should respond_to(:name=) }
  it { should respond_to(:queue_name=) }
  it { should respond_to(:start_time=) }
  it { should respond_to(:slots=) }
  it { should respond_to(:state=) }
  it { should respond_to(:owner=) }
  
  it "should retrieve data from XML document" do
    string = %Q{
    <job_list state="running">
      <JB_job_number>2337</JB_job_number>
      <JAT_prio>0.55451</JAT_prio>
      <JB_name>s20100220_11;init_jour</JB_name>
      <JB_owner>prodsoft</JB_owner>
      <state>r</state>
      <JAT_start_time>2010-02-24T21:55:13</JAT_start_time>
      <queue_name>calcul-x@wousdat-dev.in.weborama.fr</queue_name>
      <slots>1</slots>
    </job_list>
    }
    doc = Nokogiri::XML::Document.new.parse(string)
    lambda{ @job = SGE::Job.from_document(doc) }.should_not raise_error
    @job.job_number.should == '2337'
    @job.priority.should ==  '0.55451'
    @job.name.should == 's20100220_11;init_jour'
    @job.owner.should == 'prodsoft'
    @job.state.should == 'r'
    @job.start_time.should == '2010-02-24T21:55:13'
    @job.queue_name.should == 'calcul-x@wousdat-dev.in.weborama.fr'
    @job.slots.should == '1'
  end
  
end


