-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.calA_eq
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.calA_eq (hv : minkSq v = -1) (hS : IsSpatial v S) (hTc : IsSpatial v Tc)
    (hSsymm : Sᵀ = S) (hTcanti : Tcᵀ = -Tc) :
    calA v (polyMom e T S Tc u v) = (-2 * e) • Tc := by sorry
