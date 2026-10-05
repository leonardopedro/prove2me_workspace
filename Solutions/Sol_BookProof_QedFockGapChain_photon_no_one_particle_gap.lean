-- Generated from ChapterQedFockGapChain.lean — solution of BookProof.QedFockGapChain.photon_no_one_particle_gap
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Theorems.Thm_BookProof_QedFockGapChain_diagOnePart_no_form_gap
open BookProof.QedFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {p : ℕ → ℝ} (hIR : ∀ ε : ℝ, 0 < ε → ∃ k, |p k| < ε)
    {m : ℝ} (hm : 0 < m) :
    ∃ x : finiteModeDomain hermiteBasis, (x : Lp ℂ 2 (volume : Measure ℝ)) ≠ 0 ∧
      quadForm ((finiteModeDomain hermiteBasis).subtype.comp
          (diagOnePart hermiteBasis (photonDispersion p))) x
        < m * ‖(x : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2 := by

  obtain ⟨k, hk⟩ := hIR m hm
  exact diagOnePart_no_form_gap hermiteBasis (photonDispersion p) (k := k) hk
