-- Generated from ChapterSmDiracSpinor.lean — theorem BookProof.SmDiracSpinor.dirac_field_esa
import Definitions.Def_ChapterCPTHamiltonian
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmCar
open BookProof.SmDiracYukawa
open BookProof.SmDiracSpinor

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}



open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section


theorem BookProof.SmDiracSpinor.dirac_field_esa {om : Fin 4 → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) :
    EssentiallySelfAdjointOn (fullDom 4)
      ((onFull (smFermiHam (diracOneParticle k m1 m2) (0 : Matrix (Fin 4) (Fin 4) ℂ) 0)).comp
        (Submodule.inclusion (le_refl (fullDom 4)))) := by sorry
