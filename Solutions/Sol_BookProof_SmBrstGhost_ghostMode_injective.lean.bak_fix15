-- Generated from ChapterSmBrstGhost.lean — solution of BookProof.SmBrstGhost.ghostMode_injective
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
open BookProof.SmBrstGhost




open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) : Function.Injective (ghostMode m) := by

  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)
