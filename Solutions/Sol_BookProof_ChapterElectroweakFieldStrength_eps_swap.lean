-- Generated from ChapterElectroweakFieldStrength.lean — solution of BookProof.ChapterElectroweakFieldStrength.eps_swap
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength



open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution (a b c : Fin 3) : eps a b c = -eps b a c := by

  fin_cases a <;> fin_cases b <;> fin_cases c <;> simp [eps]
