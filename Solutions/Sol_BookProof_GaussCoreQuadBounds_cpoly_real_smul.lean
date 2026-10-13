-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.cpoly_real_smul
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_C
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_mul
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
theorem solution (c : ℝ) (q : MvPolynomial (Fin D) ℂ) :
    cpoly (((c : ℝ) : ℂ) • q) = ((c : ℝ) : ℂ) • cpoly q := by

  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul, cpoly_mul, cpoly_C,
    Complex.conj_ofReal]
