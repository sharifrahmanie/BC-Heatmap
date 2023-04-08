require(ComplexHeatmap)
require(readr)
# By @biomedical_informatics Edris Sharif Rahmani April 8, 2023
df <- data.frame(read_csv("bc_top50.csv"))
df <- df[order(df$subtype), ]
subtype <- df$subtype
df <- df[,-ncol(df)]
df <- t(df)
colnames(df) <- subtype
type <- colnames(df)
ha = HeatmapAnnotation(
  df = data.frame(Subtypes = type),
  col = list(Subgroups = c("Basal"= "#7570B3","Her2"= "#E7298A",
                           "LumA"= "#E6AB02","LumB" = "#66A61E",
                           "Normal" = "#666666")),
  annotation_height = unit(4, "mm"))
h <- Heatmap(df,
        row_names_gp = gpar(fontsize = 8),
        bottom_annotation= ha,
        border_gp = gpar(col = "black"),
        row_title = "",
        show_row_names = TRUE,
        cluster_rows = FALSE,
        cluster_columns = FALSE,
        row_title_side = "left",
        show_column_names = FALSE,
        heatmap_legend_param = list(legend_direction = "vertical",
                                    legend_height = unit(50, "mm"),
                                    grid_width = unit(6, "mm"),
                                    grid_height = unit(50, "cm"),
                                    title = "Expression"))
pdf(paste0("Heatmap.pdf"), width = 10, height = 6)
print(h)
dev.off()
