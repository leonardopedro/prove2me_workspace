-- Generated from ChapterG.lean — solution of BookProof.ChapterG.swap_mem_gaugeGroup
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [DecidableEq X] {π : X → Y}
    {x x' : X} (h : π x = π x') :
    Equiv.swap x x' ∈ gaugeGroup π := by

  intro z
  rcases eq_or_ne z x with hzx | hzx
  · subst hzx; rw [Equiv.swap_apply_left]; exact h.symm
  · rcases eq_or_ne z x' with hzx' | hzx'
    · subst hzx'; rw [Equiv.swap_apply_right]; exact h
    · rw [Equiv.swap_apply_of_ne_of_ne hzx hzx']
