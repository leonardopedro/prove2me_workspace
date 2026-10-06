-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.linear_trace
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.linear_trace (G : Fin 3 → ℂ) (j : Fin 3) :
    ((∑ m, G m • ((1 / 2 : ℂ) • pauliV m)) * pauliV j).trace = G j := by sorry
