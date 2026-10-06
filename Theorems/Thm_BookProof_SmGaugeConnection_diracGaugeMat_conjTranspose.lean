-- Generated from ChapterSmGaugeConnection.lean — theorem BookProof.SmGaugeConnection.diracGaugeMat_conjTranspose
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmDiracSpinor
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian
open BookProof.SmGaugeConnection

variable {N d : ℕ}



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section


theorem BookProof.SmGaugeConnection.diracGaugeMat_conjTranspose {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin d → Matrix (Fin N) (Fin N) ℂ} {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) :
    (diracGaugeMat k m1 m2 g T A)ᴴ = diracGaugeMat k m1 m2 g T A := by sorry
