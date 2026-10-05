-- Generated from ChapterGravityProjDirectSum.lean — theorem BookProof.ChapterGravityProjDirectSum.isCompl_range_of_add_eq_id
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterGravityTimeProj
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
open BookProof.ChapterGravityProjDirectSum


open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

theorem BookProof.ChapterGravityProjDirectSum.isCompl_range_of_add_eq_id {R V : Type*} [CommRing R] [AddCommGroup V] [Module R V]
    (P Q : V →ₗ[R] V) (hsum : P + Q = LinearMap.id)
    (hPQ : P.comp Q = 0) (hQP : Q.comp P = 0) :
    IsCompl (LinearMap.range P) (LinearMap.range Q) := by sorry
