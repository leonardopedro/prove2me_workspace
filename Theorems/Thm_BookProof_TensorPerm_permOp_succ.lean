-- Generated from ChapterTensorPermutation.lean — theorem BookProof.TensorPerm.permOp_succ
import Definitions.Def_ChapterGroupAverageEsa
import Mathlib
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterTensorGraphCore
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.TensorCore
open BookProof.TensorPerm



open scoped TensorProduct
open BookProof.TensorCore BookProof.GroupAverage

noncomputable section

variable (E : BookProof.TensorCore.IPSpace)

theorem BookProof.TensorPerm.permOp_succ (n : ℕ) (σ : Equiv.Perm (Fin (n + 1))) :
    permOp E (n + 1) σ = (swap0 E (n + 1) (Equiv.Perm.decomposeFin σ).1).trans
      (liftTail E (permOp E n (Equiv.Perm.decomposeFin σ).2)) := by sorry
