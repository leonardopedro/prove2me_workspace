-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.u_evaluates_to_value
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesFlow_field_evaluates_to_value
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
    (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → ι → E →ₗ[ℂ] E) (X : ι → E →ₗ[ℂ] E) (x : ι → ℂ)
    (v : E) (hv : ∀ i, X i v = x i • v) (i : Fin 3) :
    fieldTaylor (u i) (uD i) X x v = u i v := field_evaluates_to_value (u i) (uD i) X x v hv
