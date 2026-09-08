-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.harmonic_add_bounded_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_symmetricOn
import Theorems.Thm_BookProof_QgHermiteOscillator_potCore_pgLp
import Theorems.Thm_BookProof_QgHermiteOscillator_potCore_symmetricOn
import Theorems.Thm_BookProof_QgHermiteOscillator_hamCore_add_potential
import Theorems.Thm_BookProof_QgHermiteOscillator_expBounded_of_bounded
import Theorems.Thm_BookProof_QgHermiteOscillator_norm_potLp_le
open BookProof.QgHermiteOscillator












open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {B : Vd d → ℝ} {M : ℝ}
    (hBc : Continuous B) (hM : ∀ x, |B x| ≤ M)
    (hsc : Continuous fun x => harmW x + B x) (hsb : ExpBounded fun x => harmW x + B x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + B x) hsc hsb) := by

  have hBb : ExpBounded B := expBounded_of_bounded hM
  have hM0 : 0 ≤ M := le_trans (abs_nonneg _) (hM 0)
  rw [hamCore_add_potential harmW B continuous_harmW expBounded_harmW hBc hBb hsc hsb]
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded _ _
    harmonicCore_symmetricOn harmonicCore_essentiallySelfAdjoint
    (potCore_symmetricOn B hBc hBb) le_rfl one_pos hM0 fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  rw [hx, potCore_pgLp]
  simpa using norm_potLp_le (d := d) hBc hBb hM p
