-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.dirDeriv_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution {f : (Fin 3 → ℝ) → ℝ} {L : (Fin 3 → ℝ) →L[ℝ] ℝ} {x : Fin 3 → ℝ}
    (hf : HasFDerivAt f L x) (j : Fin 3) : dirDeriv f j x = L (evec j) := by

  have h : HasDerivAt (fun t : ℝ => x + t • evec j) (evec j) 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).smul_const (evec j)).const_add x
  have hf' : HasFDerivAt f L (x + (0 : ℝ) • evec j) := by simpa using hf
  first
    | exact (hf'.comp_hasDerivAt 0 h).deriv
    | (simp only [dirDeriv]; exact (hf'.comp_hasDerivAt 0 h).deriv)
    | (simp only [dirDeriv] <;> convert (hf'.comp_hasDerivAt 0 h).deriv using 1
        <;> (first | rfl | simp))
