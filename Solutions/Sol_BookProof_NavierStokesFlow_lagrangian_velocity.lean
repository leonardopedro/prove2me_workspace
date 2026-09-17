-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.lagrangian_velocity
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} (X : ℝ → Fin d → ℝ) (u : (Fin d → ℝ) → Fin d → ℝ)
    (h : ∀ t i, HasDerivAt (fun s => X s i) (u (X t) i) t) (t : ℝ) (i : Fin d) :
    deriv (fun s => X s i) t = u (X t) i := (h t i).deriv
