-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.quadForm_harm_nonneg
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_quadForm_nonneg
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.GaussCoreQuadBounds




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

open BookProof.QgOuterFockFL
noncomputable section

variable {D : ℕ}

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    0 ≤ quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := harmonicCore_quadForm_nonneg _
