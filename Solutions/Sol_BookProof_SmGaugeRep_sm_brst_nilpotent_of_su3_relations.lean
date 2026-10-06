-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.sm_brst_nilpotent_of_su3_relations
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
import Theorems.Thm_BookProof_SmBrstGhost_smBrstCharge_nilpotent
import Theorems.Thm_BookProof_YangMillsSU3_structureConstant_antisymm_swap
import Theorems.Thm_BookProof_YangMillsSU3_structureConstant_jacobi
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    (hS3 : TraceOrthonormal S3) (hf3 : ClosesWithStructureConstants S3 f3)
    (hT : ClosesWithStructureConstants T (smStruct f3)) :
    smBrstCharge m T f3 * smBrstCharge m T f3 = 0 :=
  smBrstCharge_nilpotent hT (structureConstant_antisymm_swap hS3 hf3)
      (structureConstant_jacobi hS3 hf3)
