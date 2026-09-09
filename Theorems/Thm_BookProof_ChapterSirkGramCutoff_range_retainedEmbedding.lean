-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.range_retainedEmbedding
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff









noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

theorem BookProof.ChapterSirkGramCutoff.range_retainedEmbedding {d : ℕ} (w : Fin m → E)
    (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ)
    (e : Fin d → Fin m) :
    LinearMap.range (retainedEmbedding w u lam e :
        EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E)
      = Submodule.span ℂ (Set.range (retainedVec w u lam e)) := by sorry
