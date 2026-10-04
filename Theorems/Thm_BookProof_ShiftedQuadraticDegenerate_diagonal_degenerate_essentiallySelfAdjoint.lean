-- Generated from ChapterShiftedQuadraticDegenerate.lean — theorem BookProof.ShiftedQuadraticDegenerate.diagonal_degenerate_essentiallySelfAdjoint
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticDegenerate
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadraticDegenerate

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.ShiftedQuadraticDegenerate.diagonal_degenerate_essentiallySelfAdjoint (c b b' : Fin d → ℝ)
    (hb : ∀ i, c i = 0 → b i = 0) (hb' : ∀ i, c i = 0 → b' i = 0) :
    EssentiallySelfAdjointOn
      (polyGaussCoreT (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2))
      (shiftedHMatOp (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2) (Matrix.diagonal c) b b') := by sorry
