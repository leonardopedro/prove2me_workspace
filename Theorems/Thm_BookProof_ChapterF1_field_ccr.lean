-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.field_ccr
import Mathlib
import Definitions.Def_ChapterF1
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.field_ccr :
    fieldPhi ∘ₗ fieldPi - fieldPi ∘ₗ fieldPhi = (2 * Complex.I) • LinearMap.id := by sorry
