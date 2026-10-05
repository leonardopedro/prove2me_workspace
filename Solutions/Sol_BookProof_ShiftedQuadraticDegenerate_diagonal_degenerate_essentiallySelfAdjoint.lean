-- Generated from ChapterShiftedQuadraticDegenerate.lean — solution of BookProof.ShiftedQuadraticDegenerate.diagonal_degenerate_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticDegenerate
import Theorems.Thm_BookProof_ShiftedQuadraticDegenerate_shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium
import Theorems.Thm_BookProof_ShiftedQuadraticDegenerate_diagonal_mulVec_diagShiftVec
open BookProof.ShiftedQuadraticDegenerate




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.ShiftedQuadraticMatrix
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.StoneEigenflow

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c b b' : Fin d → ℝ)
    (hb : ∀ i, c i = 0 → b i = 0) (hb' : ∀ i, c i = 0 → b' i = 0) :
    EssentiallySelfAdjointOn
      (polyGaussCoreT (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2))
      (shiftedHMatOp (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2) (Matrix.diagonal c) b b') :=
  shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium (Matrix.isHermitian_diagonal_iff.mpr
        (fun i => IsSelfAdjoint.all (c i))) b b' _ _
      (diagonal_mulVec_diagShiftVec fun i hi => by rw [hb i hi]; ring)
      (diagonal_mulVec_diagShiftVec fun i hi => by rw [hb' i hi]; norm_num)
