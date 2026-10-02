-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.qgOuterFock_truncation_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgTruncationResolvent_strongResolventConvergence_of_core
import Theorems.Thm_BookProof_QgTruncationResolvent_secCore_dense
import Theorems.Thm_BookProof_QgTruncationResolvent_secHam_esa_core
import Theorems.Thm_BookProof_QgTruncationResolvent_secHam_truncate_eventually_eq
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendsto
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_trotterKato_tendstoUniformlyOn
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        StrongResolventConvergence T S ∧
        ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by

  obtain ⟨T, -, hT, -⟩ := exists_stone_flow_of_esa (secHam W Q) secCore_dense
    (secHam_symmetricOn W Q) (secHam_esa_core W Q)
  have hSex : ∀ n : ℕ, ∃ Sn : UnboundedSelfAdjoint (Sec ι),
      IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) Sn.op := by
    intro n
    obtain ⟨Sn, -, hSn, -⟩ := exists_stone_flow_of_esa (secHam W (truncModes Q (Λ n)))
      secCore_dense (secHam_symmetricOn W (truncModes Q (Λ n)))
      (secHam_esa_core W (truncModes Q (Λ n)))
    exact ⟨Sn, hSn⟩
  choose S hS using hSex
  have hconv : ∀ x : secCore (ι := ι),
      Tendsto (fun n => secHam W (truncModes Q (Λ n)) x) atTop (𝓝 (secHam W Q x)) := by
    intro x
    have hev : (fun _ : ℕ => secHam W Q x)
        =ᶠ[atTop] fun n => secHam W (truncModes Q (Λ n)) x := by
      filter_upwards [secHam_truncate_eventually_eq W Q Λ hexh x] with n hn using hn.symm
    exact Tendsto.congr' hev tendsto_const_nhds
  have hres : StrongResolventConvergence T S :=
    strongResolventConvergence_of_core (secHam_esa_core W Q) hT hS hconv
  exact ⟨T, S, hT, hS, hres, fun v T₀ hT₀ =>
    ⟨trotterKato_tendstoUniformlyOn T S hres v hT₀, fun t => trotterKato_tendsto T S hres v t⟩⟩
