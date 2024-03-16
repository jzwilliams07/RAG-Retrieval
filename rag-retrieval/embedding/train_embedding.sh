

if [ ! -d "./output" ]; then
    mkdir -p ./output
    echo "mkdir output"
fi

if [ ! -d "./logs" ]; then
    mkdir -p ./logs
    echo "mkdir logs"
fi

# reberta pretrain softmax loss(bge的数据)
CUDA_VISIBLE_DEVICES="0"   nohup  accelerate launch --config_file ../../config/default_fsdp.yaml train_embedding.py  \
--model_name_or_path "hfl/chinese-roberta-wwm-ext" \
--dataset "../../example_data/t2rank_100.json" \
--output_dir "./output/t2ranking_100_example" \
--batch_size 8 \
--lr 5e-5 \
--epochs 2 \
--save_on_epoch_end 1 \
--gradient_accumulation_steps 12  \
--log_with 'wandb' \
--warmup_proportion 0.1 \
--neg_nums 15 \
--temperature 0.02 \
--query_max_len 128 \
--passage_max_len 512 \
 >./logs/t2ranking_100_example.log &

