-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.attentionOutput_eq_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutput

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.attentionOutput_eq_headOutput (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (r : ℝ)
    (hnorm : ∀ l, ‖k l‖ = r) :
    attentionOutput q k v = headOutput 2 (fun l => (inner ℝ q (k l) : ℝ)) v := by sorry
