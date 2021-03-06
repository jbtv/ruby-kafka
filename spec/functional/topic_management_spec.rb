describe "Topic management API", functional: true do
  example "creating topics" do
    topic = generate_topic_name
    expect(kafka.topics).not_to include(topic)

    kafka.create_topic(topic, num_partitions: 3)

    partitions = kafka.partitions_for(topic)

    expect(partitions).to eq 3
  end

  example "deleting topics" do
    topic = generate_topic_name

    kafka.create_topic(topic, num_partitions: 3)
    expect(kafka.partitions_for(topic)).to eq 3

    kafka.delete_topic(topic)
    expect(kafka.has_topic?(topic)).to eql(false)
  end
end
