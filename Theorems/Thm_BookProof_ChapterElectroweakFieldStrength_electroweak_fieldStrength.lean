-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.electroweak_fieldStrength
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.electroweak_fieldStrength (g : ℂ) (hg : g ≠ 0) (G Wμ Wν : Fin 3 → ℂ) (j : Fin 3) :
    proj g (Fmat g G Wμ Wν) j = G j - g * ∑ k, ∑ l, eps j k l * Wμ k * Wν l := by sorry
