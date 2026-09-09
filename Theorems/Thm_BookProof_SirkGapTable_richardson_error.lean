-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.richardson_error
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable









noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]














open Real

theorem BookProof.SirkGapTable.richardson_error {D C l1 l2 p d1 d2 eps : ℝ}
    (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p)
    (h1 : |d1 - (D + C * l1 ^ (-p))| ≤ eps) (h2 : |d2 - (D + C * l2 ^ (-p))| ≤ eps) :
    |richardson d1 d2 l1 l2 p - D| ≤ eps * (1 + 2 / ((l2 / l1) ^ p - 1)) := by sorry
