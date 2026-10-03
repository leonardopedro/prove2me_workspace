-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.sum_norm_sq_mul_le_of_pointwise
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_gaussInt_re_mono
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_pgLp_sq
import Theorems.Thm_BookProof_GaussCoreQuadBounds_eval_cpoly_self_re
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_smul
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_sum
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
 := 
