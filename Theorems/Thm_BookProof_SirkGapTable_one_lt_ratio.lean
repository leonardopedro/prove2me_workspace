-- Generated from ChapterSirkGapTable.lean — theorem BookProof.SirkGapTable.one_lt_ratio
import Definitions.Def_ChapterSirkCertifiedGap
import Mathlib
import Definitions.Def_ChapterSirkGapTable
open BookProof.SirkGapTable

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section


open BookProof.SirkCertifiedGap

theorem BookProof.SirkGapTable.one_lt_ratio {l1 l2 p : ℝ} (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p) :
    1 < (l2 / l1) ^ p := by sorry
