-- Generated from ChapterLayerNorm.lean — theorem BookProof.ChapterLayerNorm.scoreSoftmax_layerNorm_ge
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterTotalVariance
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open ChapterTotalVariance
open BookProof.ChapterLayerNorm

variable {d : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterLayerNorm.scoreSoftmax_layerNorm_ge {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (hd : 0 < d)
    {q : Fin d → ℝ} {k : Fin m → (Fin d → ℝ)} (hq : 0 < variance q)
    (hk : ∀ j, 0 < variance (k j)) (j : Fin m) :
    Real.exp (-(beta * (2 * d))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => ∑ i, layerNorm q i * layerNorm (k l) i) j := by sorry
