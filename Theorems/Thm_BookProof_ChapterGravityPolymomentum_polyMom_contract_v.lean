-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.polyMom_contract_v
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.polyMom_contract_v (hv : minkSq v = -1) (hS : IsSpatial v S) (hTc : IsSpatial v Tc) :
    (polyMom e T S Tc u v).mulVec (lower v) = (-e) • (((4 / 3) * T) • v + (2 : ℝ) • u) := by sorry
