-- Generated from ChapterPermutationSectorEsa.lean — theorem BookProof.PermSector.sectorOp_permOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.TensorCore
open BookProof.PermSector

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

theorem BookProof.PermSector.sectorOp_permOp (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨permOp Hs n σ (x : (Hs.pow n).carrier),
        permOp_mem_sectorDom Hs D₂ n σ x.2⟩
      = permOp Hs n σ (sectorOp Hs D₂ A n x) := by sorry
