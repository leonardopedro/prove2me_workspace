-- Generated from ChapterSirkGapTable.lean — solution of BookProof.SirkGapTable.richardson_error
import Mathlib
import Definitions.Def_ChapterSirkGapTable
import Theorems.Thm_BookProof_SirkGapTable_one_lt_ratio
import Theorems.Thm_BookProof_SirkGapTable_richardson_exact
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkGapTable










noncomputable section


open BookProof.SirkCertifiedGap



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]










variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]














open Real

set_option maxHeartbeats 1000000 in
theorem solution {D C l1 l2 p d1 d2 eps : ℝ}
    (hl1 : 0 < l1) (hl : l1 < l2) (hp : 0 < p)
    (h1 : |d1 - (D + C * l1 ^ (-p))| ≤ eps) (h2 : |d2 - (D + C * l2 ^ (-p))| ≤ eps) :
    |richardson d1 d2 l1 l2 p - D| ≤ eps * (1 + 2 / ((l2 / l1) ^ p - 1)) := by

  have hX : 1 < (l2 / l1) ^ p := one_lt_ratio hl1 hl hp
  set X := (l2 / l1) ^ p - 1 with hXdef
  have hXpos : 0 < X := by simp only [hXdef]; linarith
  have hexact : richardson (D + C * l1 ^ (-p)) (D + C * l2 ^ (-p)) l1 l2 p = D :=
    richardson_exact hl1 hl hp
  set e1 := d1 - (D + C * l1 ^ (-p)) with he1
  set e2 := d2 - (D + C * l2 ^ (-p)) with he2
  have hdiff : richardson d1 d2 l1 l2 p - D = e2 + (e2 - e1) / X := by
    have : richardson d1 d2 l1 l2 p
        - richardson (D + C * l1 ^ (-p)) (D + C * l2 ^ (-p)) l1 l2 p
        = e2 + (e2 - e1) / X := by
      simp only [richardson, he1, he2, hXdef]
      field_simp
      ring
    rw [← hexact]
    exact this
  rw [hdiff]
  have hb1 : |e1| ≤ eps := h1
  have hb2 : |e2| ≤ eps := h2
  have hsplit : |e2 + (e2 - e1) / X| ≤ |e2| + (|e2| + |e1|) / X := by
    calc |e2 + (e2 - e1) / X| ≤ |e2| + |(e2 - e1) / X| := abs_add_le _ _
      _ = |e2| + |e2 - e1| / X := by rw [abs_div, abs_of_pos hXpos]
      _ ≤ |e2| + (|e2| + |e1|) / X := by
          gcongr
          exact abs_sub _ _
  have hmono : |e2| + (|e2| + |e1|) / X ≤ eps + (eps + eps) / X := by gcongr
  have : eps + (eps + eps) / X = eps * (1 + 2 / X) := by field_simp; ring
  linarith [hsplit, hmono, this.le, this.ge]
