-- Generated from ChapterSmGaugeRepresentation.lean — theorem BookProof.SmGaugeRep.sm_brst_nilpotent_rep
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsSU3
open BookProof.SmBrstGhost
open BookProof.SmCar
open BookProof.YangMillsSU3
open BookProof.SmGaugeRep



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

theorem BookProof.SmGaugeRep.sm_brst_nilpotent_rep (hS3 : TraceOrthonormal S3)
    (hf3 : ClosesWithStructureConstants S3 f3) (y : ℝ) :
    smBrstCharge 6 (smGen S3 y) f3 * smBrstCharge 6 (smGen S3 y) f3 = 0 := by sorry
