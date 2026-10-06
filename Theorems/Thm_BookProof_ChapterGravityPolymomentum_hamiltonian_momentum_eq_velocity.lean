-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.hamiltonian_momentum_eq_velocity
import Definitions.Def_ChapterGravityProjector
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.hamiltonian_momentum_eq_velocity (he : e ≠ 0) (Scal E : Matrix (Fin 4) (Fin 4) ℝ)
    (P trE R : ℝ) (hS : Scal = (2 * e) • S) (hP : P = -4 * e * T) :
    (1 / (16 * e)) * contract Scal Scal - (1 / (24 * e)) * P ^ 2
        + (1 / 2) * contract Scal E + (1 / 3) * P * trE - e * R
      = e * ((1 / 4) * contract S S - (2 / 3) * T ^ 2 + contract S E
        - (4 / 3) * T * trE - R) := by sorry
