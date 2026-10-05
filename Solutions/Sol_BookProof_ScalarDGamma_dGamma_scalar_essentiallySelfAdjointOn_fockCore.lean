-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.dGamma_scalar_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_isGraphCore_scalarOp
import Theorems.Thm_BookProof_ScalarDGamma_essentiallySelfAdjointOn_fockSectorDom_scalar
import Theorems.Thm_BookProof_SecondQuantizationCore_dGamma_essentiallySelfAdjointOn_fockCore
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ Hs.carrier}
    (hdense : Dense (D : Set Hs.carrier)) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs ⊤ D n))
      (dGammaCoreOp Hs ⊤ (scalarOp Hs c) D) :=
  dGamma_essentiallySelfAdjointOn_fockCore Hs ⊤ (scalarOp Hs c) D
      (isGraphCore_scalarOp Hs c hdense)
      (essentiallySelfAdjointOn_fockSectorDom_scalar Hs c)
