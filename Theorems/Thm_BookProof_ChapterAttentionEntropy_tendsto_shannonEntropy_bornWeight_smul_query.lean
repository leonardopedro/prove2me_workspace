-- Generated from ChapterAttentionEntropy.lean — theorem BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_bornWeight_smul_query
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionEntropy

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_bornWeight_smul_query {n : ℕ}
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ)
    (hk : ∀ l, ‖k l‖ = r) (j : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) :
    Tendsto (fun c : ℝ => shannonEntropy (fun l => bornWeight (c • q) k l)) atTop (𝓝 0) := by sorry
