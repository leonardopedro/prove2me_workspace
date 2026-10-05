-- Generated from ChapterPvmMeasure.lean — solution of BookProof.ChapterPvmMeasure.pvmMeasure_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterPvmMeasure
open BookProof.ChapterPvmMeasure



open MeasureTheory
open scoped InnerProductSpace


variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H)
variable (P : Pvm X H) (ψ : H)

set_option maxHeartbeats 1000000 in
theorem solution {E : Set X} (hE : MeasurableSet E) :
    pvmMeasure P ψ E = 0 ↔ P.p E ψ = 0 := by

  rw [pvmMeasure_apply P ψ hE, ENNReal.ofReal_eq_zero]
  constructor
  · intro h
    have : ‖P.p E ψ‖ ^ 2 = 0 := le_antisymm h (by positivity)
    simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  · intro h
    simp [h]
