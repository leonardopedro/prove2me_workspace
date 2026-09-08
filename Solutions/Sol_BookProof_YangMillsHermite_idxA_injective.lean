-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.idxA_injective
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

















































variable {D : Submodule ℂ (L2d d)}












variable {D : Submodule ℂ (L2d 99)}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (fun p : Fin 3 × Fin 8 => idxA p.1 p.2) := by

  rintro ⟨j, a⟩ ⟨j', a'⟩ h
  have := congrArg Fin.val h
  simp only [idxA] at this
  have hj : j.val = j'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Fin.ext_iff, hj, ha]
