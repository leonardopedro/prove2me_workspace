-- Generated from ChapterSmGaugeRepresentation.lean — theorem BookProof.SmGaugeRep.smGen_closes
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterA4
open BookProof.SmBrstGhost
open BookProof.YangMillsSU3
open BookProof.SmGaugeRep

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

theorem BookProof.SmGaugeRep.smGen_closes (hS3 : ClosesWithStructureConstants S3 f3) (y : ℝ) :
    ClosesWithStructureConstants (smGen S3 y) (smStruct f3) := by sorry
