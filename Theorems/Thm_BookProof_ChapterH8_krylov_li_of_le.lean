-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.krylov_li_of_le
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap


theorem BookProof.ChapterH8.krylov_li_of_le {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearIndependent ℂ (fun i : Fin m => (H ^ (i : ℕ)) v) := by sorry
