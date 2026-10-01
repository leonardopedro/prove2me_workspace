-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.fqOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_fqOp_deficiencyTrivialAt
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp P Q S b b') :=
  ⟨fqOp_deficiencyTrivialAt P Q S b b' (by simp),
      fqOp_deficiencyTrivialAt P Q S b b' (by simp)⟩
