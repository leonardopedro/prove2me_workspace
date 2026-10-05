-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.dense_fockSectorDom
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_sectorDom_top
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Dense ((fockSectorDom Hs ⊤ n : Submodule ℂ (fockSector Hs n)) :
      Set (fockSector Hs n)) := by

  have h : ((fockSectorDom Hs ⊤ n : Submodule ℂ (fockSector Hs n)) : Set (fockSector Hs n))
      = Set.range (sectorEmb Hs n) := by
    rw [fockSectorDom, sectorDom_top, pushDom, Submodule.map_top, LinearMap.coe_range]
    rfl
  rw [h]
  exact UniformSpace.Completion.denseRange_coe
