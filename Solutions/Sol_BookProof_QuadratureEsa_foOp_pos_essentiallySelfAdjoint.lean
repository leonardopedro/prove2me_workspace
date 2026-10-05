-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_pos_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_foOp_pos_deficiencyTrivialAt
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (foOp b 0) := ⟨foOp_pos_deficiencyTrivialAt b (by simp), foOp_pos_deficiencyTrivialAt b (by simp)⟩
