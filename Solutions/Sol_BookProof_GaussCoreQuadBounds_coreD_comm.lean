-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.coreD_comm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_QuantumGravity3DGauge_pderiv_comm_poly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.GaussCoreQuadBounds




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

noncomputable section

variable {D : ℕ}

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin D) (p : MvPolynomial (Fin D) ℂ) :
    coreD j (coreD k p) = coreD k (coreD j p) := by

  simp only [coreD, map_sub, pderiv_mul, pderiv_C, pderiv_X, mul_sub]
  rw [BookProof.QuantumGravity3DGauge.pderiv_comm_poly j k p]
  simp only [Pi.single_apply]
  by_cases hjk : j = k
  · subst hjk; ring
  · rw [if_neg hjk, if_neg (Ne.symm hjk)]
    ring
