-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.dGamma_diagCol_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_creVec_diagCol
import Theorems.Thm_BookProof_FockOneParticleGap_creA_annA_single
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_single
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (β : Conf) (c : ℂ) :
    dGamma (diagCol e) (Finsupp.single β c)
      = ((confEnergy e β : ℝ) : ℂ) • Finsupp.single β c := by

  classical
  rw [dGamma_single]
  have hterm : ∀ k ∈ β.support,
      creVec (diagCol e k) (annA k (Finsupp.single β (1 : ℂ)))
        = (((β k : ℝ) * e k : ℝ) : ℂ) • Finsupp.single β (1 : ℂ) := by
    intro k _
    rw [creVec_diagCol, creA_annA_single, smul_smul]
    push_cast
    ring_nf
  rw [Finset.sum_congr rfl hterm, ← Finset.sum_smul,
    show (∑ k ∈ β.support, (((β k : ℝ) * e k : ℝ) : ℂ)) = ((confEnergy e β : ℝ) : ℂ) by
      rw [confEnergy]; push_cast; ring,
    smul_smul, Finsupp.smul_single, Finsupp.smul_single]
  congr 1
  simp [mul_comm]
