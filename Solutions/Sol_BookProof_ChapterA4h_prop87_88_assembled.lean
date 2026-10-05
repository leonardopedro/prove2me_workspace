-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.prop87_88_assembled
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA4h_prop87_assembled
import Theorems.Thm_BookProof_ChapterA4h_prop88_energy_sign_not_conserved
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

variable (R : Type*)

set_option maxHeartbeats 1000000 in
theorem solution (Mk : MackeyImprimitivity R)
    (Wg : WignerClassification R Mk) (ρ : R) :
    (PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.massive ∨
      PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.masslessDiscrete) ∧
    ¬ ∀ j : Fin 3, projPos * spatialOp j = spatialOp j * projPos := ⟨prop87_assembled R Mk Wg ρ, prop88_energy_sign_not_conserved⟩
