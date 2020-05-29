#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"

#define DEBUG_TYPE "samplepass"

using namespace llvm;
namespace {
struct SamplePass : public ModulePass {
  static char ID;
  SamplePass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    bool modified = false;
    LLVM_DEBUG(dbgs() << "I'm here!\n");
    return modified;
  }
};

char SamplePass::ID = 0;
static RegisterPass<SamplePass> X("samplepass", "Sample Pass", false, false);
} // namespace

#undef DEBUG_TYPE