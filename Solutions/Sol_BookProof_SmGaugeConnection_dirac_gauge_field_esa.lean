-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.dirac_gauge_field_esa
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_diracGaugeMat_conjTranspose
import Theorems.Thm_BookProof_SmDiracYukawa_sm_fermi_esa
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {A : Fin 8 → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a)
    {om : Fin 12 → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) :
    EssentiallySelfAdjointOn (fullDom 12)
      ((onFull (smFermiHam (Matrix.reindex modeEquiv modeEquiv (diracGaugeMat k m1 m2 g T A))
          (0 : Matrix (Fin 12) (Fin 12) ℂ) 0)).comp
        (Submodule.inclusion (le_refl (fullDom 12)))) :=
  sm_fermi_esa (om := om) (c0 := c0)
      (by rw [Matrix.conjTranspose_reindex, diracGaugeMat_conjTranspose hT]) hom hc0
