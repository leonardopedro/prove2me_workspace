-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.u_evaluates_to_value
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.u_evaluates_to_value {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
    (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → ι → E →ₗ[ℂ] E) (X : ι → E →ₗ[ℂ] E) (x : ι → ℂ)
    (v : E) (hv : ∀ i, X i v = x i • v) (i : Fin 3) :
    fieldTaylor (u i) (uD i) X x v = u i v := by sorry
