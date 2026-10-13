-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — solution of BookProof.ShiftedQuadraticMatrix.shiftedHMatCore_dense
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Theorems.Thm_BookProof_ShiftedHermiteCore_polyGaussCoreT_dense
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedQuadraticMatrix




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (b b' : Fin d → ℝ) :
    Dense ((polyGaussCoreT (matShiftVec A b) (matBoostVec A b')
      : Submodule ℂ (L2d d)) : Set (L2d d)) := polyGaussCoreT_dense _ _
