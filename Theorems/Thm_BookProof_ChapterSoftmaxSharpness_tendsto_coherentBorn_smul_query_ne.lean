-- Generated from ChapterSoftmaxSharpness.lean — theorem BookProof.ChapterSoftmaxSharpness.tendsto_coherentBorn_smul_query_ne
import Mathlib
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn


theorem BookProof.ChapterSoftmaxSharpness.tendsto_coherentBorn_smul_query_ne (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j i : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) (hi : i ≠ j) :
    Tendsto (fun c : ℝ => bornWeight (c • q) k i) atTop (𝓝 0) := by sorry
