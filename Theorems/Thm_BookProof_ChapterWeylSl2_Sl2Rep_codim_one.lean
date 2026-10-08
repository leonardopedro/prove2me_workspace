-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.codim_one
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterDoubleSlit
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2



universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

theorem BookProof.ChapterWeylSl2.Sl2Rep.codim_one : ∀ (n : ℕ) {V : Type u} [AddCommGroup V] [Module ℂ V]
    [FiniteDimensional ℂ V] (R : Sl2Rep V) (phi : V →ₗ[ℂ] ℂ) (v0 : V), phi v0 = 1 →
    (∀ v, phi (R.E v) = 0) → (∀ v, phi (R.F v) = 0) → (∀ v, phi (R.H v) = 0) →
    Module.finrank ℂ (LinearMap.ker phi) ≤ n →
    ∃ v : V, phi v = 1 ∧ R.E v = 0 ∧ R.F v = 0 ∧ R.H v = 0 := by sorry
